# Streaming Platform Analytics using SQL

## Project Overview

This project analyzes user behavior, content engagement, subscription patterns, retention, and revenue trends for a streaming platform similar to Netflix. The objective is to derive actionable business insights that can support customer retention, content strategy, and revenue growth.

---

## Business Objective

The analysis focuses on answering key business questions:

* Who are the most engaged users?
* Which content drives the highest engagement?
* How are users transitioning between subscription plans?
* How effectively is the platform retaining users?
* What is the current revenue contribution from active subscribers?

---

## Database Schema

The project uses a relational database consisting of four core tables:

### Users

Stores user demographic information and registration details.

### Subscriptions

Contains subscription plans, payment amounts, and subscription lifecycle information.

### Content

Stores metadata about movies and series, including genre and content type.

### Viewing History

Captures user viewing activity, watch duration, and engagement behavior.

### Relationships

* `users` → `subscriptions`
* `users` → `viewing_history`
* `content` → `viewing_history`

These relationships simulate a real-world OTT platform data model.

---

## Analysis Performed

### 1. High Engagement Users

Identified users with high watch time and analyzed their consumption patterns across movies and series.

**Business Value**

* Identifies power users
* Supports recommendation system improvements
* Helps understand content consumption behavior

---

### 2. Revenue Tracking

Extracted each user's latest subscription to determine current revenue contribution.

**Business Value**

* Tracks active revenue-generating customers
* Supports revenue forecasting
* Helps monitor subscription performance

---

### 3. Plan Preference Analysis

Analyzed users who subscribed to multiple plans, such as Premium and Basic, to understand plan-switching behavior.

**Business Value**

* Detects upgrades and downgrades
* Supports pricing strategy decisions
* Identifies customer preferences

---

### 4. Retention Analysis

Measured how many users remained active across consecutive months to evaluate short-term retention.

**Business Value**

* Tracks user stickiness
* Evaluates platform engagement
* Supports customer retention initiatives

---

### 5. First Content Interaction Analysis

Identified the first content watched after user signup.

**Business Value**

* Improves onboarding experience
* Supports recommendation engine optimization
* Helps understand initial user preferences

---

### 6. Subscription Lifecycle Analysis

Classified users as new or renewed subscribers based on subscription history.

**Business Value**

* Measures customer acquisition
* Tracks customer retention
* Supports lifecycle management strategies

---

## Key Skills Demonstrated

* SQL Querying
* Joins
* Common Table Expressions (CTEs)
* Window Functions
* Aggregations
* Business KPI Analysis
* Retention Analysis
* Revenue Analysis
* User Behavior Analytics
* Relational Data Modeling

---

## Conclusion

This project demonstrates how SQL can be used to transform raw streaming platform data into meaningful business insights.

The analysis provides visibility into:

* User engagement
* Subscription behavior
* Customer retention
* Revenue performance
* Content effectiveness

These insights can directly support growth, retention, monetization, and customer experience strategies for a streaming platform.
