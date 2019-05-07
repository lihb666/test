<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:tx="http://www.springframework.org/schema/tx"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
	http://www.springframework.org/schema/beans/spring-beans.xsd
	http://www.springframework.org/schema/context
	http://www.springframework.org/schema/context/spring-context.xsd
	http://www.springframework.org/schema/aop
	http://www.springframework.org/schema/aop/spring-aop.xsd
	http://www.springframework.org/schema/tx 
	http://www.springframework.org/schema/tx/spring-tx.xsd">
	
	<!--引入propertise文件  -->
		<!--传统方式引入  -->
<!-- 	<bean class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer"> -->
<!-- 		<property name="locations" value="classpath:db.properties"></property> -->
<!-- 	</bean> -->
	
	<!--简化方式  -->
	<context:property-placeholder location="classpath:db.properties"/>	
	
	<!--1.配置数据源:c3p0  -->
	<bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
		<property name="driverClass" value="${driver}" />
		<property name="jdbcUrl" value="${url}" />
		<property name="user" value="${user}" />
		<property name="password" value="${passwd}" />
	</bean>
	
	<!--2.配置mybatis的SqlSession的工厂: SqlSessionFactoryBean dataSource:引用数据源 -->
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource"></property>
		<property name="typeAliasesPackage" value="com.ssm.bean" />
	</bean>
	
	<!-- 3. 自动扫描mybatis映射文件和接口的包 -->
	<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		<property name="basePackage" value="com.ssm.dao"></property>
	</bean>
	
	<!--4.配置事务管理器  -->
	<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource"></property>
	</bean>
	
	<!--5.开启注解进行事务管理   transaction-manager：引用上面定义的事务管理器-->
	<tx:annotation-driven transaction-manager="transactionManager"/>
</beans>
