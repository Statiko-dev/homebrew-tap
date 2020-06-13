class Stkcli < Formula
    desc "A CLI to manage Statiko nodes and apps"
    homepage "https://github.com/Statiko-dev/stkcli"
    url "https://github.com/Statiko-dev/stkcli/archive/v0.5.0-beta.3.tar.gz"
    sha256 "a5dd6a13b3bd832eb548d81da094b85f07ec8110d423b3f4d5f45ddf1668aeb7"
  
    depends_on "go" => ["1.13", :build]
  
    def install
        ENV["GOPATH"] = buildpath
        ENV["GO111MODULE"] = "on"
        ENV["CGO_ENABLED"] = "0"
        ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
        (buildpath/"src/github.com/Statiko-dev/stkcli").install buildpath.children
        cd "src/github.com/Statiko-dev/stkcli" do
            system "go", "build", "-ldflags", "-X github.com/statiko-dev/stkcli/buildinfo.BuildID=v0.5.0-beta.3 -X github.com/statiko-dev/stkcli/buildinfo.CommitHash=brew", "-o", bin/"stkcli", "."
        end
    end
  
    test do
        assert_match /stkcli Build ID\: v0\.5\.0\-beta\.3/, shell_output("#{bin}/stkclli version", 0)
    end
end
