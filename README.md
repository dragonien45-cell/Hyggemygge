# Hyggemygge

Et browserbaseret Ubuntu XFCE-skrivebord til GitHub Codespaces med Chromium og lydstreaming.

## Start

1. Åbn repositoryets **Code**-menu på GitHub.
2. Vælg **Codespaces** og opret eller start et Codespace.
3. Port **3000** videresendes og åbnes automatisk, så snart skrivebordet er klar.
4. Hvis fanen ikke åbner, vælg **Ports**, find port **3000**, og vælg **Open in Browser**.

Porten er privat og kræver din GitHub-login. GitHub leverer den videresendte adresse via HTTPS, hvilket er nødvendigt for browserens lyd- og videofunktioner.

## Automatisk opstart

Webtop kører som containerens hovedtjeneste. Codespaces starter derfor Ubuntu-skrivebordet sammen med containeren ved hver launch. En `postStartCommand` kontrollerer ved hver launch, at standardport 3000 svarer, og Codespaces åbner porten, når den bliver registreret.

## Indhold

- Ubuntu XFCE
- Chromium
- Browserbaseret fjernskrivebord
- Lyd fra det eksterne Chromium til din lokale browser
- Privat, automatisk videresendt port 3000

## Anvend ændringen på et eksisterende Codespace

Efter en ændring af devcontainer-konfigurationen skal det eksisterende Codespace genopbygges én gang:

1. Åbn kommandopaletten med **Ctrl+Shift+P**.
2. Kør **Codespaces: Rebuild Container**.
3. Efter genopbygningen starter porten automatisk ved fremtidige launches.

Hvis et gammelt Codespace fortsat bruger port 6080, er det ikke blevet genopbygget med den nye konfiguration.

## Forbrug

GitHub Free inkluderer 120 core-timer pr. måned. En 2-core Codespace-maskine bruger to core-timer pr. faktisk time og giver derfor cirka 60 timers faktisk brug pr. måned.

Stop Codespacet, når du ikke bruger det. Et stoppet Codespace bruger ikke compute-timer, men det optager fortsat lagerplads.

## Fejlfinding

Hvis port 3000 ikke bliver klar efter en genopbygning:

```bash
cat /tmp/hyggemygge-desktop-check.log
ss -ltnp
ps -p 1 -o args=
```

Loggen viser nu både containerens hovedproces og lyttende porte, hvis opstarten fejler.
