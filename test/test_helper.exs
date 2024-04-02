ExUnit.start()
ExUnit.configure(exclude: [])

Application.put_env(:ex_hubspot, :rest_url, System.get_env("HS_REST_URL"))
Application.put_env(:ex_hubspot, :hs_access_token, System.get_env("HS_ACCESS_TOKEN"))
Application.put_env(:ex_hubspot, :retry, System.get_env("HS_RETRY") || false)
Application.put_env(:ex_hubspot, :secret, System.get_env("HS_SECRET"))
