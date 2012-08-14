package Minty.services;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: karthik.s
 * Date: 14/8/12
 * Time: 3:21 PM
 * To change this template use File | Settings | File Templates.
 */

@Service
public class DBAccessService {

    private JdbcTemplate jdbcTemplate;

    public DBAccessService() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setUrl("jdbc:postgresql://127.0.0.1:5432/mydb2");
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUsername("postgres");
        dataSource.setPassword("postgres");
        JdbcTemplate db = new JdbcTemplate(dataSource);

        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
    public int queryForInt(String sql, Map<String, ?> args){

        return jdbcTemplate.queryForInt(sql,args);
    }
    
    public int queryForInt(String sql, SqlParameterSource args){
        return jdbcTemplate.queryForInt(sql,args);
    }
    
    public int queryForInt(String sql, Object... args){
        return jdbcTemplate.queryForInt(sql,args);
    }

    public long queryForLong(String sql, Object... args){
        return jdbcTemplate.queryForInt(sql,args);
    }

    public <T> T queryforObject(String sql, Class<T> requiredtype, Map<String, ?> args) {
        return jdbcTemplate.queryForObject(sql,requiredtype,args);
    }
    
    public <T> T queryForObject(String sql, Class<T> requiredType, SqlParameterSource args) {
        return jdbcTemplate.queryForObject(sql, requiredType, args);
    }
    
    public <T> T queryForObject(String sql, Class<T> requiredType, Object... args){
        return jdbcTemplate.queryForObject(sql,requiredType,args);
    }

    public <T> T queryForObject(java.lang.String sql, org.springframework.jdbc.core.RowMapper<T> rowMapper, java.lang.Object... args) throws org.springframework.dao.DataAccessException {
        return jdbcTemplate.queryForObject(sql,rowMapper,args);
    }


    public Map<String, Object> queryForMap(String sql, Map<String, ?> args) {
        return jdbcTemplate.queryForMap(sql, args);
    }
    
    public Map<String, Object> queryForMap(String sql, SqlParameterSource args) {
        return jdbcTemplate.queryForMap(sql,args);
    }
    
    public Map<String, Object> queryForMap(String sql, Object... args){
        return jdbcTemplate.queryForMap(sql,args);
    }
    
    public int update(String sql, Map<String, ?> args) {
        return jdbcTemplate.update(sql,args);
    }
    
    public int update(String sql, SqlParameterSource args) {
        return jdbcTemplate.update(sql,args);
    }
    
    public int update(String sql, Object... args){
        return jdbcTemplate.update(sql,args);
    }
    
    public List<Map<String, Object>> queryForList(String sql, Map<String, ?> args){
        return jdbcTemplate.queryForList(sql, args);
    }
    
    public List<Map<String, Object>> queryForList(String sql, SqlParameterSource args){
        return jdbcTemplate.queryForList(sql,args);
    }
    
    public List<Map<String, Object>> queryForList(String sql, Object... args) {
        return jdbcTemplate.queryForList(sql,args);
    }

    public <T> java.util.List<T> query(java.lang.String sql, org.springframework.jdbc.core.RowMapper<T> rowMapper, java.lang.Object... args) throws org.springframework.dao.DataAccessException
    {
        return jdbcTemplate.query(sql,rowMapper,args);
    }
}