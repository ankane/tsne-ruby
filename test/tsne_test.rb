require_relative "test_helper"

class TSNETest < Minitest::Test
  def test_works
    data = Numo::DFloat.cast([[0, 0, 0], [0, 1, 1], [1, 0, 1], [1, 1, 1]])
    tsne = TSNE.new(random_state: 123)
    embeddings = tsne.fit_transform(data)

    assert_equal [4, 2], embeddings.shape

    if windows?
      assert_in_delta 0.19657319566021392, tsne.kl_divergence, 0.01
    elsif mac? && arm?
      assert_in_delta 1167.2154880888247, embeddings[0, true][0]
      assert_in_delta (-604.6910489554791), embeddings[0, true][1]
      assert_in_delta 0.21556545721320178, tsne.kl_divergence
    elsif mac?
      assert_in_delta (-438.231549), embeddings[0, true][0]
      assert_in_delta 0.310034518, embeddings[0, true][1]
      assert_in_delta 0.19657319566021392, tsne.kl_divergence
    else
      assert_in_delta (-1049.43900138), embeddings[0, true][0]
      assert_in_delta (-895.52140476), embeddings[0, true][1]
      assert_in_delta 0.16304681779803065, tsne.kl_divergence
    end

    assert_equal 1000, tsne.n_iter
  end

  def windows?
    Gem.win_platform?
  end

  def mac?
    RbConfig::CONFIG["host_os"] =~ /darwin/i
  end

  def arm?
    RbConfig::CONFIG["host_cpu"] =~ /arm|aarch64/i
  end
end
