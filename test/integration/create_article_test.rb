require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

    def setup
        @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    end

    test "get new article form and create article" do
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        assert_difference 'Article.count', 1 do
            post articles_path, params: { article: { title:"sports", description: "description", user: @user } }
        end
        follow_redirect!
        assert_template 'articles/show'
    end

    test "invalid article submission results in failure" do
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        assert_no_difference 'Article.count' do
            post articles_path, params: { article: { title: " ", description: " ", user: @user } }
        end
        assert_template 'articles/new'
        assert_select "h2.panel-title"
        assert_select "div.panel-body"
    end

end