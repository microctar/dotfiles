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

switch (uname -o)
case GNU/Linux
  function redeemwalletcode -d "Redeem a Steam Gift Card or Wallet Code"
    firefox --new-tab "https://store.steampowered.com/account/redeemwalletcode"
  end
case Android
  function redeemwalletcode -d "Utiliser une carte ou un code de portemonnaie"
    am start -W -a android.intent.action.VIEW -d "https://store.steampowered.com/account/redeemwalletcode"
  end
end
