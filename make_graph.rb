#
# Program:
#   make_graph.rb : make AS network topology for graphviz
#
# Usage:
#   cat 201601_Result_Traceroute_AS.csv | ruby make_graph.rb 
#   http://www.webgraphviz.com/
#
# Expected CSV format:
#   Target (hostname),Target (ipaddr),Target (ccTLD),Hop 0,Hop 1,Hop 2, ...
#
# Version:
#   2016/01/11 : Release 1st version

printf("digraph asnetwork {\n")
printf("  ratio = fill;\n")
printf("  graph [concentrate=true];\n")
printf("  node [style=filled];\n")

output = Array.new
output_beginnode = Array.new
output_country = Array.new
while (line = STDIN.gets) do
  data = line.split(",")

  next if (data[0] == "Target (hostname)")
  next if (data.length < 4)
  aspath = data[3..data.length-2].collect {|d|
    d.sub!("AS", "")
    begin
      Integer(d)
    rescue
      0
    end
  }
  aspath.delete_if {|d| d==0}

  for i in 0..(aspath.length-2) do
    as0 = aspath[i]
    as1 = aspath[i+1]
    output.push([as0, as1])
  end

  output_beginnode.push(aspath[0])
  if (data[2] != nil or data[2] != "") then
    output_country.push(data[2].upcase)
    output.push([as1, data[2].upcase])
  end
end

output_country.uniq.each do |d|
  printf(" %s [shape = box, style = filled, color = \"#ffffff\", fillcolor = \"#ff0000\"];\n", d)
end
output_beginnode.uniq.each do |d|
  printf(" %s [shape = box, style = filled, color = \"#ffffff\", fillcolor = \"#00ffff\"];\n", d)
end

output.uniq.each do |d|
  printf("  %s -> %s;\n", d[0], d[1])
end
printf("}\n")

exit
