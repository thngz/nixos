{
  trivialBuild,
  fetchFromGitHub,
}:
trivialBuild rec {
  pname = "vue-ts-mode";
  version = "0-unstable-2024-12-22";
  
  src = fetchFromGitHub {
    owner = "8uff3r";
    repo = "vue-ts-mode";
    rev = "main";
    hash = "sha256-cBOAWbag+tmKlORNKcbntF71ar+CZ2DojAGMucn7DJE=";
  };
}
