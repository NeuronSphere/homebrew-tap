class Bartleby < Formula
  desc "Render reStructuredText documentation using Sphinx inside Docker"
  homepage "https://github.com/neuronsphere/hmd-cli-bartleby"
  license "MIT"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/neuronsphere/hmd-cli-bartleby/releases/download/v#{version}/bartleby_#{version}_darwin_arm64.tar.gz"
      # sha256 "PLACEHOLDER" # uncomment and fill after first release
    else
      url "https://github.com/neuronsphere/hmd-cli-bartleby/releases/download/v#{version}/bartleby_#{version}_darwin_amd64.tar.gz"
      # sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/neuronsphere/hmd-cli-bartleby/releases/download/v#{version}/bartleby_#{version}_linux_arm64.tar.gz"
      # sha256 "PLACEHOLDER"
    else
      url "https://github.com/neuronsphere/hmd-cli-bartleby/releases/download/v#{version}/bartleby_#{version}_linux_amd64.tar.gz"
      # sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "bartleby"
  end

  def caveats
    <<~EOS
      bartleby requires Docker to run documentation builds.
      If you use Colima, make sure it is running:
        colima start
    EOS
  end

  test do
    assert_match "bartleby", shell_output("#{bin}/bartleby --help")
  end
end
