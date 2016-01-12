# Abstract:
This is a program for visualizing AS paths from excersise in my lecture.

# Program:
make_graph.rb : make AS network topology for graphviz

# Usage:
> cat 201601_Result_Traceroute_AS.csv | ruby make_graph.rb 
> http://www.webgraphviz.com/

# Expected CSV format:
> Target (hostname),Target (ipaddr),Target (ccTLD),Hop 0,Hop 1,Hop 2, ...

# Version:
- 2016/01/11 : Release 1st version
