package TwitMini.controller;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;

import java.io.IOException;
import java.util.logging.FileHandler;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

/**
 * Created with IntelliJ IDEA.
 * User: kunjan
 * Date: 24/7/12
 * Time: 4:11 PM
 * To change this template use File | Settings | File Templates.
 */


    @Configuration
    public class AppConfig {

        @Bean
        public JdbcTemplate jdbcTemplate() {
            BasicDataSource dataSource = new BasicDataSource();
            dataSource.setUrl("jdbc:postgresql://127.0.0.1:5432/mydb2");
            dataSource.setDriverClassName("org.postgresql.Driver");
            dataSource.setUsername("postgres");
            dataSource.setPassword("crossword");
            JdbcTemplate db = new JdbcTemplate(dataSource);


            try {
                int a =  db.queryForInt("SELECT COUNT(*) FROM USERS;");
            }
            catch (Exception e) {
                //TODO:Remove Sysout
                System.out.print(e.toString());
                db.update("CREATE TABLE USERS (" +
                        "user_id SERIAL," +
                        "PRIMARY KEY(user_id)," +
                        "realname varchar(30) NOT NULL," +
                        "email varchar(40) NOT NULL," +
                        "username varchar(40) NOT NULL," +
                        "user_password varchar(40) NOT NULL," +
                        "num_followers INTEGER DEFAULT 0," +
                        "num_following INTEGER DEFAULT 0," +
                        "num_tweets INTEGER DEFAULT 0" +
                        ");");
            }



            try {
                int a =  db.queryForInt("SELECT COUNT(*) FROM TWEETS;");
            }
            catch (Exception e) {
                //TODO:Remove Sysout
                System.out.print(e.toString());
                db.update("\n" +
                        "CREATE TABLE tweets\n" +
                        "(\n" +
                        "  tweet_id serial NOT NULL,\n" +
                        "  user_id integer,\n" +
                        "  tweet character varying(128) NOT NULL,\n" +
                        "  username character varying(40) NOT NULL,\n" +
                        "  pushtime timestamp without time zone DEFAULT now(),\n" +
                        "  CONSTRAINT tweets_pkey PRIMARY KEY (tweet_id),\n" +
                        "  CONSTRAINT tweets_user_id_fkey FOREIGN KEY (user_id)\n" +
                        "      REFERENCES users (user_id) MATCH SIMPLE\n" +
                        "      ON UPDATE NO ACTION ON DELETE NO ACTION\n" +
                        ")\n" +
                        "WITH (\n" +
                        "  OIDS=FALSE\n" +
                        ");\n" +
                        "ALTER TABLE tweets OWNER TO postgres;\n");
            }


            try {
                int a =  db.queryForInt("SELECT COUNT(*) FROM FOLLOWING;");
            }
            catch (Exception e) {
                //TODO:Remove Sysout
                System.out.print(e.toString());
                db.update("CREATE TABLE following\n" +
                        "(\n" +
                        "  user_id integer,\n" +
                        "  following_id integer,\n" +
                        "  CONSTRAINT following_following_id_fkey FOREIGN KEY (following_id)\n" +
                        "      REFERENCES users (user_id) MATCH SIMPLE\n" +
                        "      ON UPDATE NO ACTION ON DELETE NO ACTION,\n" +
                        "  CONSTRAINT following_user_id_fkey FOREIGN KEY (user_id)\n" +
                        "      REFERENCES users (user_id) MATCH SIMPLE\n" +
                        "      ON UPDATE NO ACTION ON DELETE NO ACTION\n" +
                        ")\n" +
                        "WITH (\n" +
                        "  OIDS=FALSE\n" +
                        ");\n" +
                        "ALTER TABLE following OWNER TO postgres;");
            }

            try {
                int a =  db.queryForInt("SELECT COUNT(*) FROM USERFEED;");
            }
            catch (Exception e) {
                //TODO:Remove Sysout
                System.out.print(e.toString());
                db.update("\n" +
                        "CREATE TABLE userfeed\n" +
                        "(\n" +
                        "  user_id integer,\n" +
                        "  tweet_id integer,\n" +
                        "  CONSTRAINT userfeed_tweet_id_fkey FOREIGN KEY (tweet_id)\n" +
                        "      REFERENCES tweets (tweet_id) MATCH SIMPLE\n" +
                        "      ON UPDATE NO ACTION ON DELETE NO ACTION,\n" +
                        "  CONSTRAINT userfeed_user_id_fkey FOREIGN KEY (user_id)\n" +
                        "      REFERENCES users (user_id) MATCH SIMPLE\n" +
                        "      ON UPDATE NO ACTION ON DELETE NO ACTION\n" +
                        ")\n" +
                        "WITH (\n" +
                        "  OIDS=FALSE\n" +
                        ");\n" +
                        "ALTER TABLE userfeed OWNER TO postgres;");
            }
            return db;
        }

    @Bean
    public ThreadLocal<Long> userID() {
        return new ThreadLocal<Long>();
    }

    @Bean
    public Logger logger(){

        Logger logger = Logger.getLogger("MyLog");
        FileHandler fh;

        try {

            // This block configure the logger with handler and formatter
            fh = new FileHandler("/home/kunjan/Karthik/speakOUT/src/main/webapp/static/userActivityLog.log",true);
            logger.addHandler(fh);
            //logger.setLevel(Level.ALL);
            SimpleFormatter formatter = new SimpleFormatter();
            fh.setFormatter(formatter);

            // the following statement is used to log any messages
            logger.info("-------------------------------------------------------------------------------------------");
            logger.info("-------------------------------------------------------------------------------------------");
            logger.info("Minty Server log");

        } catch (SecurityException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        //logger.info("Log Test");
        return logger;

    }

}
