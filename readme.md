# Dossier Méthodologique — Projet Pinball Cuphead

**Bloc 2 — Gestion de projet | Compétence C2.1**

Équipe : Arthur Guillemin, Émilie [nom], Kelly [nom], Ryan [nom], Younes [nom]

---

## 1. Contexte et organisation de l'équipe

Le projet Pinball Cuphead consiste à développer un flipper virtuel complet pour un cabinet d'arcade physique Fliphetic : trois écrans synchronisés en temps réel (playfield 3D, backglass, DMD), un backend centralisant la logique de jeu, et une carte ESP32 gérant les boutons physiques.

L'équipe est composée de cinq personnes, avec une répartition par domaine de responsabilité :

| Membre | Rôle principal | Responsabilités complémentaires |
|---|---|---|
| Arthur | Développeur backend | DevOps (Docker, GitHub Actions), déploiement cabinet, support front |
| Émilie | Développeuse front — DMD | Design des textures du flipper |
| Kelly | Développeuse front — Backglass | — |
| Ryan | Développeur front — Playfield | Modélisation 3D (Blender) |
| Younes | Communication MQTT (ESP32) | Développement front — DMD |

Cette répartition par écran/composant a permis de paralléliser le travail : chaque membre était responsable d'un repository, avec des points de synchronisation réguliers pour les interfaces communes (protocole WebSocket, topics MQTT, format des données).

Contrainte d'organisation notable : trois membres de l'équipe étaient en alternance, deux (Arthur et Younes) travaillaient à distance. L'organisation a donc été pensée pour fonctionner en asynchrone, avec des outils de communication et de suivi accessibles à tous en permanence.

---

## 2. Choix et justification de l'approche méthodologique

### 2.1 Méthode retenue : Scrum adapté

Nous avons choisi une approche **Scrum adaptée** à notre contexte étudiant, avec des sprints d'une semaine calés sur les semaines de cours.

**Pourquoi Scrum plutôt qu'une autre méthode :**

- **Le projet avait une forte incertitude technique initiale** : communication temps réel entre quatre composants, physique 3D, hardware ESP32. Une méthode itérative permettait de valider les choix techniques progressivement plutôt que de tout planifier à l'avance (approche cascade inadaptée).
- **Les interfaces entre composants évoluaient** : le protocole WebSocket entre le backend et les écrans a été raffiné à chaque sprint en fonction des besoins réels du front. Scrum permet d'intégrer ces ajustements sans casser la planification.
- **L'équipe était distribuée** (alternance + distanciel) : le cadre Scrum, avec ses rituels courts et réguliers, structure la communication sans exiger de présence permanente.

**Pourquoi "adapté"** : nous n'avons pas appliqué Scrum de manière dogmatique. Pas de Product Owner ni de Scrum Master dédiés — ces rôles étaient portés collectivement. Pas de rétrospective formelle systématique — les ajustements de méthode se faisaient en fin de daily quand nécessaire. Nous assumons ces adaptations : sur une équipe de cinq étudiants, formaliser tous les rôles Scrum aurait ajouté de la lourdeur sans bénéfice.

### 2.2 Rythme des sprints

- **Sprint d'une semaine**, aligné sur les semaines de cours.
- **Sprint planning le lundi matin** : définition des objectifs de la semaine, découpage en issues GitHub, assignation par membre.
- **Daily meeting** (Discord) : point d'avancement rapide, identification des blocages, coordination sur les interfaces communes.
- **Fin de sprint** : vérification des objectifs atteints, report des tâches non terminées au sprint suivant avec repriorisation.

---

## 3. Outils de gestion de projet et versioning

### 3.1 Outils et usage

| Outil | Usage dans le processus |
|---|---|
| **GitHub Projects** | Board centralisé regroupant les issues de tous les repositories du projet. Colonnes : Backlog / To Do / In Progress / Review / Done. Chaque objectif de sprint est décliné en issues assignées le lundi matin. |
| **GitHub Issues** | Chaque tâche est une issue rattachée à son repository, liée au board central. Les Pull Requests référencent les issues qu'elles résolvent. |
| **Discord** | Serveur d'équipe avec salons par sujet (backend, playfield, backglass, dmd, hardware, général). Daily meetings en vocal. Notifications automatiques de déploiement envoyées par les pipelines CI/CD via webhook. |
| **Figma** | Maquettes des écrans (backglass, DMD) et validation visuelle avant intégration. |
| **GitHub** | Versioning de l'ensemble des repositories (backend, playfield, backglass, dmd, firmware ESP32, configuration cabinet). |

Le lien entre outils et processus est direct : le sprint planning du lundi produit des issues dans GitHub Projects, chaque issue devient une branche, chaque branche devient une Pull Request reviewée, chaque merge déclenche la CI/CD qui notifie Discord. Le cycle complet est outillé de bout en bout.

### 3.2 Stratégie de versioning : Git Flow

Nous avons appliqué une stratégie **Git Flow** identique sur tous les repositories :

```
feature/nom-de-la-feature  →  dev  →  main
```

- **Une branche par feature**, créée depuis `dev`, nommée selon la convention `feature/xxx` (ou `fix/xxx`, `refactor/xxx`).
- **Merge dans `dev`** via Pull Request une fois la feature terminée et testée.
- **Merge de `dev` dans `main`** lorsque l'état de `dev` est validé et prêt à être livré. Le merge sur `main` déclenche le pipeline de production (build Docker multi-plateforme, scan de sécurité, déploiement).

**Règles explicites appliquées sur tous les repos :**

- **Aucune Pull Request ne peut être mergée sans la review d'un autre membre de l'équipe.** Cette règle, configurée dans les protections de branches GitHub, garantit qu'au moins deux personnes connaissent chaque portion de code.
- **Conventional Commits obligatoires**, appliqués techniquement par **husky + commitlint** : un commit qui ne respecte pas la convention (`feat:`, `fix:`, `chore:`...) est rejeté localement avant même le push.
- **Versioning automatique par semantic-release** : les numéros de version sont calculés automatiquement à partir des messages de commit (feat → version mineure, fix → patch). Chaque release génère un tag Git et un changelog sans intervention manuelle.

---

## 4. Standards de qualité logicielle

Les standards qualité ont été définis dès le début du projet et intégrés aux pipelines, de sorte qu'ils s'appliquent automatiquement à chaque contribution.

### 4.1 Qualité du code

- **Linter (ESLint)** exécuté dans la CI sur chaque Pull Request — le code non conforme bloque le merge.
- **Formatage (Prettier)** appliqué automatiquement via lint-staged au moment du commit.
- **Tests automatisés** exécutés en CI avant tout build : le backend dispose de trois niveaux de tests (unitaires sur la logique de jeu, intégration sur l'API HTTP, end-to-end sur le WebSocket). Un test qui échoue bloque le déploiement.
- **Code review systématique** : chaque Pull Request est relue par un autre membre avant merge (règle bloquante).

### 4.2 Sécurité

- **GitGuardian** : scan automatique de fuite de secrets (clés API, tokens) sur chaque push et Pull Request, sur l'ensemble des repositories. Ce scan a détecté une fuite réelle en cours de projet (webhook Discord en dur dans un workflow), corrigée immédiatement.
- **Trivy** : scan de vulnérabilités (niveaux HIGH et CRITICAL) sur chaque image Docker construite, avec remontée des résultats dans l'onglet GitHub Security au format SARIF.
- **Gestion des secrets** : aucune variable sensible dans le code. Injection via les secrets GitHub Actions en CI, et via des fichiers `.env` locaux non versionnés en déploiement.

### 4.3 Traçabilité des livraisons

- **Semantic-release** : chaque déploiement est associé à une version, un tag Git et un changelog générés automatiquement.
- **Notifications Discord automatiques** à chaque déploiement (succès ou échec), avec lien direct vers les logs du pipeline — toute l'équipe est informée en temps réel de l'état des livraisons.

---

## 5. Processus itératif

Le cycle complet d'une contribution, identique sur tous les repositories :

1. **Lundi — sprint planning** : les objectifs de la semaine sont découpés en issues GitHub assignées.
2. **Création d'une branche** `feature/xxx` depuis `dev` pour chaque issue.
3. **Développement** avec commits conventionnels (vérifiés par husky).
4. **Pull Request vers `dev`** : la CI se déclenche (lint, tests, scan GitGuardian).
5. **Code review obligatoire** par un autre membre — échanges et corrections éventuelles directement dans la PR.
6. **Merge dans `dev`** une fois la CI verte et la review approuvée.
7. **Daily meeting** : synchronisation sur l'avancement, identification des dépendances entre composants (ex. : le front a besoin d'un nouveau type de message WebSocket → issue créée côté backend).
8. **Merge `dev` → `main`** quand l'incrément est validé : déclenchement du pipeline de production (build multi-plateforme, Trivy, semantic-release, déploiement, notification Discord).

Ce processus garantit qu'aucun code n'atteint la production sans être passé par : la convention de commits, le linter, les tests, un scan de sécurité, et une relecture humaine.

---

## 6. Règles et contraintes explicites

**Règles d'équipe (définies au sprint 1) :**

- Une branche par feature, jamais de commit direct sur `dev` ou `main`.
- Aucun merge sans review d'un autre membre (protection de branche GitHub).
- Conventional Commits obligatoires (bloqués techniquement par husky).
- Les interfaces communes (types de messages WebSocket, topics MQTT, schéma de la base de données) ne sont modifiées qu'après accord des membres concernés en daily.
- Tout secret détecté doit être révoqué et remplacé immédiatement, jamais simplement supprimé de l'historique.

**Contraintes du projet :**

- **Matérielle** : un seul cabinet physique disponible, partagé entre les équipes — les tests en conditions réelles devaient être planifiés.
- **Organisationnelle** : trois membres en alternance, deux en distanciel — communication majoritairement asynchrone via Discord et GitHub.
- **Technique** : architecture multi-plateforme imposée (images Docker amd64 + arm64 pour le cabinet), variables d'environnement front injectées au build (contrainte Vite).
- **Temporelle** : sprints calés sur les semaines de cours, avec une disponibilité variable selon les périodes d'alternance.

---

## 7. Planification des sprints

| Sprint | Objectifs principaux |
|---|---|
| **Sprint 1** | Mise en place des repositories, des règles Git Flow, des protections de branches, des conventions. Setup des projets (React, Node.js). Maquettes Figma. Premiers prototypes : scène 3D du playfield, structure du backend. |
| **Sprint 2** | Backend : GameState, premiers endpoints WebSocket. Playfield : physique de la balle (Rapier). Backglass et DMD : structure des écrans. ESP32 : lecture des boutons, premiers messages MQTT. |
| **Sprint 3** | Protocole WebSocket complet entre backend et écrans (start_game, événements de jeu, game over). Intégration du leaderboard Supabase. Textures et assets visuels. |
| **Sprint 4** | Mise en place des pipelines CI/CD complets (lint, tests, GitGuardian, Trivy, semantic-release, notifications Discord). Tests automatisés backend (unitaires, intégration, E2E). |
| **Sprint 5** | Dockerisation de tous les composants (multi-plateforme amd64/arm64). Premier déploiement sur le cabinet Fliphetic. Résolution des problèmes d'intégration matérielle (réseau, MQTT, variables d'environnement). |
| **Sprint 6** | Stabilisation : correction des bugs identifiés en conditions réelles (double comptage capteurs, synchronisation des identifiants de capteurs). Polissage visuel et sonore. Préparation des livrables et de la documentation. |

À chaque fin de sprint, les tâches non terminées étaient repriorisées et réinjectées dans le backlog du sprint suivant, avec un point d'arbitrage collectif le lundi matin.

---

## 8. Bilan méthodologique

**Ce qui a bien fonctionné :**

- Le rythme hebdomadaire calé sur les semaines de cours a donné une cadence naturelle et prévisible.
- L'automatisation de la qualité (husky, CI, reviews bloquantes) a éliminé les débats de forme et garanti un socle de qualité constant sans effort de vigilance manuel.
- Le board GitHub centralisé a donné une visibilité complète sur l'avancement de tous les composants, essentielle pour une équipe distribuée.

**Ce qui serait amélioré sur un prochain projet :**

- Formaliser les rétrospectives de fin de sprint — les ajustements de méthode se faisaient de manière informelle.
- Mettre en place un package partagé pour les constantes communes entre front et back (types de messages, identifiants de capteurs) — leur synchronisation manuelle a causé un bug en cours de projet.
- Planifier plus tôt les créneaux de test sur le cabinet physique, ressource partagée qui s'est révélée être un goulot d'étranglement en fin de projet.
