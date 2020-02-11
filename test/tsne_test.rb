require_relative "test_helper"

class TSNETest < Minitest::Test
  def test_works
    data = Numo::DFloat.cast([[0, 0, 0], [0, 1, 1], [1, 0, 1], [1, 1, 1]])
    tsne = TSNE.new
    embeddings = tsne.fit_transform(data)

    assert_equal [4, 2], embeddings.shape

    # assert_in_delta -241.22353864, embeddings[0, true][0]
    # assert_in_delta 420.06104011, embeddings[0, true][1]

    assert_in_delta 0.19210753917008128, tsne.kl_divergence
    assert_equal 1000, tsne.n_iter
  end
end
