using HTTP
using SparseArrays
using Plots

# Global level control to slow down the crawling
isSlow = false

function surfer(root::String, n::Int, showRealtimePlot::Bool = false)
   # UPDATED VERSION

   # SURFER  Create the adjacency graph of a portion of the Web.
   #    [U,G] = surfer(root, n, showRealtimePlot)
   #
   #    Input arguments:
   #    root = the URL at which the surfing starts
   #    n = the number of nodes it forms in the adjacency graph created by following the web links starting at 'root'
   #    showRealtimePlot (optional) = boolean value; if set true we can visualize the adjacency as a spy plot in real-time
   #
   #    Output arguments:
   #    U = a cell array of n strings, the URLs of the nodes.
   #    G = an n-by-n sparse matrix with G(i,j) = 1 if node j is linked to node i.
   #
   #    Example:  (U,G) = surfer("https://inf.ethz.ch/", 500);
   #    See also PAGERANK.
   #
   #    This function currently has two defects.  (1) The algorithm for
   #    finding links is naive.  We just look for the string 'http:'.
   #    (2) An attempt to read from a URL that is accessible, but very slow,
   #    might take an unacceptably long time to complete.  In some cases,
   #    it may be necessary to have the operating system terminate MATLAB.
   #    Key words from such URLs can be added to the skip list in surfer.m.

   # For real-time visualization
   if showRealtimePlot
      gr()
   end

   # Initialize
   U = Vector{String}(undef, n)
   G = sparse(!=(0).(zeros(n, n)))
   hash = zeros(Int64, n, 1)

   m = 1
   U[m] = root
   hash[m] = hashfun(root)

   j = 1
   while j < n
      
      # Try to open a page
      println(string("\tIndexing: ", U[j]))

      # Issue with ".ico" in Julia. Adding this here instead of skipping to marker
      # the results consistent with the MATLAB version.
      if contains(U[j],".ico")
         j += 1
         continue
      end
      try
         r = HTTP.request("GET", U[j])
         if r.status != 200
            println(string("Failed: ", U[j]))
            j += 1
            continue
         end
         page = String(r.body)

         # Follow the links from the open page.
         
         for f = findall("https:", page)
            e = findfirst(page[f[1]-1], page[f[1]:end])
            if isnothing(e)
               continue
            end
            url = page[f[1]:f[1]+e-2]
            
            skips = [".gif",".jpg",".jpeg",".pdf",".css",".asp",".mwc",".ram",
               ".cgi","lmscadsi","cybernet","w3.org","google","yahoo",
               "scripts","netscape","shockwave","webex","fansonly",
               "idref.fr", "purl.org", "freedomdefined","wernfbox"];
            skip = any(url=='!') | any(url=='?');
            k = 0;
            while ~skip && (k < length(skips))
               k += 1;
               skip = contains(url,skips[k]) #~isempty(strfind(url,skips[k]));
            end
            if skip
               if ~contains(url,".gif") && ~contains(url,".jpg")
                  if isSlow
                     sleep(0.25)
                  end
               end
               continue
            end

            # Check if page is already in url list.
            println(string("\t\tChecking: ", url))

            i = 0;
            for k = findall(x->x==hashfun(url), hash[1:m])
               if isequal(U[k],url)
                  i = k;
                  break
               end
            end

            # Add a new url to the graph there if are fewer than n.

            if (i == 0) && (m < n)
               m = m+1;
               U[m] = url;
               hash[m] = hashfun(url);
               i = m;
            end

            # Add a new link.

            if i > 0
               G[i,j] = 1
               if showRealtimePlot
                  display(spy(G))
               end
               if isSlow
                  sleep(0.25)
               end
            end

         end
      catch e
         println(string("Failed: ", U[j]))
      end
      j += 1
   end

   return (U, G)
end

function hashfun(url::String)
   # Almost unique numeric hash code for pages already visited.
   return length(url) + 1024 * sum([Int(c) for c in url]);
end

(U,G) = surfer("https://www.usi.ch", 50, true);