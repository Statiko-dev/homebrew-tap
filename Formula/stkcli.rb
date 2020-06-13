class Stkcli < Formula
  desc "CLI to manage Statiko nodes and apps"
  homepage "https://github.com/Statiko-dev/stkcli"
  url "https://github.com/Statiko-dev/stkcli/archive/v0.5.0-beta.3.tar.gz"
  sha256 "f78dbabd71efca16a26e351434447ef99eff574cee9034232388f8afb40268d8"

  depends_on "go" => ["1.13", :build]

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    ENV["CGO_ENABLED"] = "0"
    ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
    (buildpath/"src/github.com/Statiko-dev/stkcli").install buildpath.children
    cd "src/github.com/Statiko-dev/stkcli" do
      system "go", "build", "-ldflags",
        "-X github.com/statiko-dev/stkcli/buildinfo.BuildID=v0.5.0-beta.3" +
        "-X github.com/statiko-dev/stkcli/buildinfo.CommitHash=brew",
        "-o", bin/"stkcli", "."
    end
  end

  test do
    assert_match /stkcli Build ID: v0\.5\.0-beta\.3/, shell_output("#{bin}/stkclli version")
  end
end
