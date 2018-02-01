defmodule LandingPageWeb.V1.LeadControllerTest do
  use LandingPageWeb.ConnCase

  describe "POST /api/v1/leads" do
    test "returns error response with invalid params /", %{conn: conn} do
      conn = post(conn, lead_path(conn, :create), %{"lead" => %{}})
      assert json_response(conn, 422) == %{
               "full_name" => ["can't be blank"],
               "email" => ["can't be blank"],
               "recaptcha_token" => ["can't be blank"],
             }
    end

    test "returns success response with valid params /", %{conn: conn} do
      params = %{"lead" => %{"full_name" => "John", "email" => "foo@bar.com", "recaptcha_token" => "foo"}}

      conn = post(conn, lead_path(conn, :create), params)
      assert json_response(conn, 200) == %{"full_name" => "John", "email" => "foo@bar.com"}
    end

    test "returns error response with invalid token", %{conn: conn} do
      params = %{
        "lead" => %{
          "full_name" => "John",
          "email" => "foo@bar.com",
          "recaptcha_token" => "invalid"
        }
      }

      conn = post(conn, lead_path(conn, :create), params)

      assert json_response(conn, 422) == %{"recaptcha_token" => ["the response is invalid"]}
    end
  end
end
