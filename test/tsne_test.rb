require_relative "test_helper"

class TSNETest < Minitest::Test
  def test_works
    data = Numo::DFloat.cast([[0, 0, 0], [0, 1, 1], [1, 0, 1], [1, 1, 1]])
    tsne = TSNE.new(random_state: 123)
    embeddings = tsne.fit_transform(data)

    assert_equal [4, 2], embeddings.shape

    # assert_in_delta -438.231549, embeddings[0, true][0]
    # assert_in_delta 0.310034518, embeddings[0, true][1]

    assert_in_delta 0.19657319566021392, tsne.kl_divergence, 0.01
    assert_equal 1000, tsne.n_iter
  end
end
