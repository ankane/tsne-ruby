module TSNE
  module FFI
    extend Fiddle::Importer

    libs = Array(TSNE.ffi_lib).dup
    begin
      dlload Fiddle.dlopen(libs.shift)
    rescue Fiddle::DLError => e
      retry if libs.any?
      raise e if ENV["TSNE_DEBUG"]
      raise LoadError, "Could not find t-SNE"
    end

    typealias "bool", "char"

    extern "void tsne_run_double(
      double* X, int N, int D, double* Y,
      int no_dims, double perplexity, double theta,
      int num_threads, int max_iter, int n_iter_early_exag,
      int random_state, bool init_from_Y, int verbose,
      double early_exaggeration, double learning_rate,
      double *final_error, int distance
    )"
  end
end
