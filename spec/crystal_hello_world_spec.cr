require "./spec_helper"

describe "Kemal::App" do
  it "renders /world" do
    get "/world"
    response.body.should eq "<html>\n  <head>\n    <meta charset=\"utf-8\">\n    <script src=\"/materialize/js/materialize.js\"></script>\n    <link rel=\"stylesheet\" href=\"/materialize/css/materialize.min.css\"/>\n    <title>world</title>\n  </head>\n  <body>\n    <div class=\"container\">\n      <p>Hello, world!</p>\n    </div>\n  </body>\n</html>\n"
  end
end
