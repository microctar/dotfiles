switch (uname -o)
case GNU/Linux
  function registerkey -d "Register steam CD key through firefox"
    firefox --new-tab "https://store.steampowered.com/account/registerkey"
  end
case Android
  function registerkey -d "Activer un produit sur Steam"
    am start -W -a android.intent.action.VIEW -d "https://store.steampowered.com/account/registerkey"
  end
end
