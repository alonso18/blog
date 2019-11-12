class Category < ApplicationRecord
    has_many :category_article
    has_many :article, through: :category_article
end
