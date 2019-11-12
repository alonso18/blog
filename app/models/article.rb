class Article < ApplicationRecord
    has_rich_text :content
    belongs_to :user
    has_many :category_articles
    has_many :categories, through: :category_articles
    attr_accessor :category_elements

    def save_categories
        #category_ids = category_elements.split(',')
        return category_articles.destroy_all if category_elements.nil? || category_elements.empty?
        category_articles.where.not(category_id: category_elements).destroy_all
        category_elements.each do |category_id|
            CategoryArticle.find_or_create_by(article: self, category_id: category_id)
        end
    end
end
