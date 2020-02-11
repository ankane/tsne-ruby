module TSNE
  class Model
    attr_reader :kl_divergence, :n_iter

    def initialize(n_components: 2, perplexity: 30.0,
      early_exaggeration: 12, learning_rate: 200,
      n_iter: 1000, n_iter_early_exag: 250, verbose: 0,
      random_state: -1, angle: 0.5, n_jobs: 1, cheat_metric: true)

      @n_components = n_components
      @perplexity = perplexity
      @early_exaggeration = early_exaggeration
      @learning_rate = learning_rate
      @n_iter = n_iter
      @n_iter_early_exag = n_iter_early_exag
      @verbose = verbose
      @random_state = random_state
      @angle = angle
      @n_jobs = n_jobs
      @cheat_metric = cheat_metric
    end

    def fit(x)
      fit_transform(x)
      self
    end

    def fit_transform(x)
      x = Numo::DFloat.cast(x) unless x.is_a?(Numo::NArray)
      x = x.cast_to(Numo::DFloat) unless x.is_a?(Numo::DFloat)
      n, d = x.shape

      x = Fiddle::Pointer[x.to_binary]
      y = Fiddle::Pointer.malloc(n * @n_components * Fiddle::SIZEOF_DOUBLE)
      final_error = Fiddle::Pointer.malloc(Fiddle::SIZEOF_DOUBLE)

      FFI.tsne_run_double(
        x, n, d, y, @n_components, @perplexity, @angle, @n_jobs,
        @n_iter, @n_iter_early_exag, @random_state, 0, @verbose, @early_exaggeration,
        @learning_rate, final_error, @cheat_metric ? 1 : 0
      )

      @kl_divergence = final_error[0, final_error.size].unpack1("d")

      Numo::DFloat.from_binary(y[0, y.size]).reshape(n, @n_components)
    end
  end
end
