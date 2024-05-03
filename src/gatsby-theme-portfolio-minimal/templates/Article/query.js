module.exports = {
  ArticleTemplateQuery: `
      query ArticleTemplateQuery {
          allArticle(sort: {date: DESC}) {
              articles: nodes {
                  banner {
                      alt
                      caption
                      src {
                          childImageSharp {
                              gatsbyImageData(width: 360, height: 300, placeholder: BLURRED)
                          }
                      }
                  }
                  body
                  categories
                  date(formatString: "MMMM DD")
                  description
                  id
                  keywords
                  slug
                  title
                  readingTime {
                      text
                    }
              }
          }
      }  
  `,
};
