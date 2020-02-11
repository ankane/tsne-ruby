import numpy as np
from MulticoreTSNE import MulticoreTSNE as TSNE

x = np.array([[0, 0, 0], [0, 1, 1], [1, 0, 1], [1, 1, 1]])
model = TSNE()
embeddings = model.fit_transform(x)

print(embeddings.shape)
print(embeddings)
print(model.kl_divergence_)
print(model.n_iter)
