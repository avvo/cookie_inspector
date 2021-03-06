# CookieInspector

This project rocks and uses MIT-LICENSE.

## use the .css
- add @import 'cookie_inspector/cookie_inspector' to your application.scss/application.css, or you can include it in your layout
```
  <% if Rails.env.development? %>
    <%= stylesheet_link_tag 'cookie_inspector/cookie_inspector', media: 'all' %>
  <% end %>
```

## make the helper available
- add `helper CookieInspector::CookieInspectorHelper if Rails.env.development` to your applicationController

- config.cookie_inspector.secret_key_base = Rails.application.config_for('secrets')['secret_key_base']

## Use the helper in your html
- add the render to your layout
```
  <% if Rails.env.development? %>
    <%= render 'cookie_inspector/cookie_inspector' %>
  <% end %>
```

## To use/view
- to turn on debug, use cookie_inspector=true param. It will stay on until you use cookie_inspector=false

## notes
- There is a guard to make sure we don't try to decrypt cookies in production
- The tests are pretty worthless right now, but the code works on my machine
