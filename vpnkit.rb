class Vpnkit < Formula
  desc "A toolkit for embedding VPN capabilities in your application"
  homepage "https://github.com/moby/vpnkit"
  url "https://github.com/moby/vpnkit",
    :using => :git,
    :revision => "ea9dbeaf887f5dad8391f4a34d127501fb6bbf64"

  version "ea9dbeaf887f5dad8391f4a34d127501fb6bbf64"

  depends_on :x11 => :build
  depends_on :xcode => ["9.0", :build]
  depends_on "aspcud" => :build
  depends_on "autoconf" => :build
  depends_on "ocaml" => :build
  depends_on "pkg-config" => :build
  # VPNKit requires an older version of OPAM, use the project's formula for 1.2.2_4.
  # The project is using this as part of their CircleCI.
  depends_on "https://gist.githubusercontent.com/djs55/7a94ee5aeb882ef5399c0485d2affdda/raw/bc04ff96e0082d7ee07642337dbb77c51b93d678/opam.rb" => :build

  def install
    ENV["OPAMYES"] = "1"
    ENV["MACOSX_DEPLOYMENT_TARGET"] = "10.10"
    ENV["CUSTOM_OPAM"] = "1"
    ENV["OPAM_REPO"] = "repo/darwin"
    ENV["OPAM_COMP"] = "4.07.0"
    ENV["OPAMVERBOSE"] = "1"
    
    system "make"
    system "mv", "vpnkit.exe", "vpnkit"
    bin.install "vpnkit"
  end

  test do
    assert_match(version.to_s, shell_output("#{bin}/vpnkit --version 2>&1"))
  end
end
