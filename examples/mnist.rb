require "matplotlib/pyplot"
require "npy"
require "tsne"

mnist = Npy.load_npz("mnist.npz")
data = mnist["x_train"].reshape(60000, 28 * 28)[0...2000, true]
target = mnist["y_train"][0...2000]

tsne = TSNE.new
embeddings = tsne.fit_transform(data)

vis_x = embeddings[true, 0]
vis_y = embeddings[true, 1]

plt = Matplotlib::Pyplot
plt.scatter(vis_x.to_a, vis_y.to_a, c: target.to_a, cmap: plt.cm.get_cmap("jet", 10), marker: ".")
plt.colorbar(ticks: 10.times.to_a)
plt.clim(-0.5, 9.5)
plt.show
