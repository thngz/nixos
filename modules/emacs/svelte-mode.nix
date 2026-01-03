{
  trivialBuild,
  fetchFromGitHub,
}:
trivialBuild {
  pname = "svelte-ts-mode";
  version = "0-unstable-2024-12-22";
  
  src = fetchFromGitHub {
    owner = "leafOfTree";
    repo = "svelte-ts-mode";
    rev = "main";
    hash = "sha256-Fco4N5d8Oxg64xebhWh1BnsPXXnCkyX/A+cjHUew5oQ=";
  };
}
