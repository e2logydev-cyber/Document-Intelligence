$template = Get-Content power-apps-development.html -Raw

function New-DetailPage {
  param(
    [string]$Path,
    [string]$Title,
    [string]$Desc,
    [string]$UseCase,
    [string[]]$HowTo,
    [string[]]$KeyCaps,
    [string]$CtaTitle,
    [string]$CtaDesc
  )

  $howToHtml = ($HowTo | ForEach-Object { '          <li>{0}</li>' -f $_ }) -join "`r`n"
  $keyHtml = ($KeyCaps | ForEach-Object { '          <div class="key-item"><span class="key-dot"></span>{0}</div>' -f $_ }) -join "`r`n"

  $html = $template
  $html = $html -replace '<title>.*?</title>', ('<title>{0} | E2logy Microsoft Services</title>' -f $Title)
  $html = $html -replace '<div class="detail-title">.*?</div>', ('<div class="detail-title">{0}</div>' -f $Title)
  $html = $html -replace '<p class="detail-desc">.*?</p>', ('<p class="detail-desc">{0}</p>`r`n    <!-- Microsoft capability claims will be verified before finalizing the content. -->' -f $Desc)

  $html = [regex]::Replace($html, '(?s)(<h3>Real-World Use Case</h3>\s*<p>).*?(</p>)', {
    param($m)
    return $m.Groups[1].Value + $UseCase + $m.Groups[2].Value
  })

  $html = [regex]::Replace($html, '(?s)(<h3>How to Use</h3>\s*<ul>).*?(</ul>)', {
    param($m)
    return $m.Groups[1].Value + "`r`n" + $howToHtml + "`r`n        " + $m.Groups[2].Value
  })

  $html = [regex]::Replace($html, '(?s)(<div class="key-list">).*?(</div>)', {
    param($m)
    return $m.Groups[1].Value + "`r`n" + $keyHtml + "`r`n        " + $m.Groups[2].Value
  })

  $html = [regex]::Replace($html, '(?s)(<div class="cta-mini">\s*<h4>).*?(</h4>)', {
    param($m)
    return $m.Groups[1].Value + $CtaTitle + $m.Groups[2].Value
  })

  $html = [regex]::Replace($html, '(?s)(<div class="cta-mini">.*?<h4>.*?</h4>\s*<p>).*?(</p>)', {
    param($m)
    return $m.Groups[1].Value + $CtaDesc + $m.Groups[2].Value
  })

  Set-Content -Path $Path -Value $html -Encoding utf8
}

New-DetailPage -Path 'power-automate-solutions.html' -Title 'Power Automate Solutions' -Desc 'Automate workflows across Microsoft 365, Azure, and your line-of-business systems with Power Automate. We design cloud flows, approvals, and desktop automation so routine work runs hands-free with full governance.' -UseCase 'A finance team needs to process supplier invoices faster. We build a flow that captures incoming invoices, routes them for approval, updates the ERP, and posts status updates to Teams — cutting turnaround time from days to hours.' -HowTo @(
  'Map the process steps, triggers, and required approvals.',
  'Choose cloud flows for SaaS systems or desktop flows for legacy apps.',
  'Connect data sources (SharePoint, Outlook, SQL, Dynamics 365, or custom APIs).',
  'Add conditions, exception handling, and notifications.',
  'Monitor run history and enforce governance with environment DLP policies.'
) -KeyCaps @(
  'Cloud, instant, and scheduled flows for end-to-end automation.',
  'Desktop flows (RPA) for legacy applications.',
  'Broad connector library plus custom connectors.',
  'Approvals, adaptive cards, and Teams notifications.',
  'Centralized governance, analytics, and run history.'
) -CtaTitle 'Automate Your Core Processes' -CtaDesc 'We identify high-impact workflows and deliver production-ready Power Automate solutions in weeks.'

New-DetailPage -Path 'power-bi-analytics-dashboards.html' -Title 'Power BI Analytics &amp; Dashboards' -Desc 'Deliver interactive dashboards and executive reporting with Power BI. We model data, define KPIs, and publish secure analytics to the web, mobile, and Microsoft Teams.' -UseCase 'A retail chain needs a unified view of sales, inventory, and margin by store. We build a Power BI model, create role-based dashboards, and schedule refreshes so leadership sees daily performance at a glance.' -HowTo @(
  'Connect data sources and shape data with Power Query.',
  'Define business metrics and KPIs using DAX measures.',
  'Design reports and dashboards with role-based access.',
  'Publish to Power BI Service and schedule refreshes.',
  'Share in Teams or SharePoint and set data alerts.'
) -KeyCaps @(
  'Semantic data models and reusable datasets.',
  'Row-level security for controlled access.',
  'Scheduled refresh and data gateway support.',
  'Embedded analytics in Teams and SharePoint.',
  'Workspace governance and sensitivity labeling.'
) -CtaTitle 'Turn Data Into Decisions' -CtaDesc 'We build Power BI dashboards that give every team the metrics they need — securely and in real time.'

New-DetailPage -Path 'microsoft-dataverse-integration.html' -Title 'Microsoft Dataverse &amp; Integration' -Desc 'Create a secure, unified data foundation with Microsoft Dataverse. We model business data, apply governance, and integrate Dataverse with Power Apps, Power Automate, and external systems.' -UseCase 'A services company needs a single customer profile across sales, support, and billing. We consolidate data into Dataverse, apply role-based access, and sync updates with the ERP and CRM.' -HowTo @(
  'Design tables, relationships, and business rules.',
  'Configure security roles, field-level security, and auditing.',
  'Ingest data via dataflows, Power Automate, or Azure Data Factory.',
  'Expose Dataverse data to apps and APIs through connectors.',
  'Monitor data quality and manage environment lifecycle.'
) -KeyCaps @(
  'Relational data modeling with metadata and validation.',
  'Security roles, auditing, and compliance controls.',
  'Dataverse Web API and connector integrations.',
  'Business rules and calculated fields.',
  'Solutions for lifecycle management across environments.'
) -CtaTitle 'Unify Your Data Layer' -CtaDesc 'We design Dataverse foundations that power secure apps, automation, and analytics.'

New-DetailPage -Path 'power-virtual-agents-copilot-studio.html' -Title 'Power Virtual Agents (Copilot Studio)' -Desc 'Build intelligent chatbots with Copilot Studio that resolve common requests, connect to enterprise systems, and escalate to live agents when needed.' -UseCase 'An IT support team wants to reduce repetitive tickets. We create a bot that answers FAQs, checks account status, and creates ITSM tickets, with seamless escalation to human agents in Teams.' -HowTo @(
  'Define topics, intents, and conversation flows.',
  'Connect actions and data using Power Automate or connectors.',
  'Configure authentication and user context where required.',
  'Test conversations and refine with analytics insights.',
  'Deploy to Teams, web chat, or other supported channels.'
) -KeyCaps @(
  'Low-code bot design with topic-based dialogs.',
  'Integration with Dataverse and Power Automate.',
  'Multi-channel deployment (Teams and web).',
  'Live-agent handoff for complex requests.',
  'Conversation analytics and quality monitoring.'
) -CtaTitle 'Launch Support Bots Faster' -CtaDesc 'We build Copilot Studio bots that reduce ticket volume while improving response times.'

New-DetailPage -Path 'power-pages-customer-partner-portals.html' -Title 'Power Pages (Customer &amp; Partner Portals)' -Desc 'Deliver secure, branded external portals with Power Pages. We build self-service experiences connected to Dataverse and integrated with Microsoft 365.' -UseCase 'A logistics company needs a customer portal for shipment status and support cases. We create a Power Pages site with secure logins, case submission forms, and automated updates.' -HowTo @(
  'Model portal data in Dataverse with appropriate permissions.',
  'Design pages, lists, and forms with branding and layout controls.',
  'Set up authentication with Microsoft Entra ID B2C or social login.',
  'Automate submissions and approvals using Power Automate.',
  'Publish and monitor usage, security, and performance.'
) -KeyCaps @(
  'Responsive external portals with built-in templates.',
  'Dataverse-backed data access and forms.',
  'Authentication, authorization, and role-based access.',
  'Workflow automation and notifications.',
  'Extensibility with custom code and integration.'
) -CtaTitle 'Deliver Secure Self-Service' -CtaDesc 'We launch Power Pages portals that reduce support load and improve customer experience.'
