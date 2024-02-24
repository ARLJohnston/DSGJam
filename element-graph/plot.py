import matplotlib.pyplot as plt
import networkx as nx

G = nx.Graph()

elements = [
"fire", "water", "air", "earth", "ice", "mud", "lightning", "lava", "nullified"
]

G.add_nodes_from(elements)

def combine(a,b,c):
    combine_label=a+"+"+b
    G.add_node(combine_label)
    G.add_edge(a,combine_label)
    G.add_edge(b,combine_label)
    G.add_edge(combine_label,c)


combine("fire", "water", "nullified")
combine("fire", "air", "lightning")
combine("fire", "earth", "lava")
combine("water", "air", "ice")
combine("water", "earth", "mud")
combine("air", "earth", "nullified")


plt.figure()
nx.draw(G, with_labels=True)
plt.draw()
plt.show()
