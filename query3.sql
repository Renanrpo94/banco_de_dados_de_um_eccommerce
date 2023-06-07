create database db_beta_ecommerce;

use db_beta_ecommerce;

show tables;

create table tb_categoria (
	id_categoria int not null primary key auto_increment,
    descricao_categoria varchar (40) not null unique
);

create table tb_frete (
uf char (2) not null primary key,
valor_frete decimal (5,2) not null  
);

create table tb_fornecedor(
id_fornecedor int not null primary key auto_increment,
razao_fornecedor varchar(60) not null,
nome_fantasia_fornecedor varchar (60) not null unique,
contato_fornecedor varchar (40) not null,
endereco_fornecedor varchar (120) not null,
fone_fornecedor char (16) not null,
email_fornecedor varchar (40) not null,
cnpj_fornecedor char (18) not null,
status_fornecedor varchar (40) not null   
);

create table tb_usuario (
	id_usuario int not null primary key auto_increment,
    email_usuario varchar (80) not null unique,
    senha_usuario varchar (20) not null,
    status_usuario varchar (40) not null
);

show tables;

create table tb_cliente (
	id_cliente int not null primary key auto_increment,
    id_usuario int not null,
    foreign key (id_usuario) references tb_usuario (id_usuario),
    nome_cliente varchar (60) not null,
    cpf_cliente char (14) not null unique,
    rg_cliente char (12) not null unique,
    fone_cliente char (16) not null,
    dta_nasc_cliente date not null,
    dta_cadastro_cliente timestamp not null default current_timestamp,
    status_cliente varchar (40) not null 
);

create table tb_vendedor (
	id_vendedor int not null primary key auto_increment,
    id_usuario int not null,
    foreign key (id_usuario) references tb_usuario (id_usuario),
    nome_vendedor varchar (60) not null,
    cnpj_vendedor char (18) not null,
    fone_vendedor char (16) not null,
    dta_cadastro_vendedor timestamp not null default current_timestamp,
    status_vendeor varchar (40) not null
);

create table tb_usuario_adm (
	id_usuario_adm int not null auto_increment primary key,
    email_usuario_adm varchar (60) not null unique,
    senha_usuario_adm varchar (20) not null unique,
    status_usuario_adm varchar (40) not null
);

create table tb_publicidade (
	id_publicidade int not null primary key auto_increment,
    id_usuario_adm int not null,
	foreign key (id_usuario_adm) references tb_usuario (id_usuario_adm),
    imagem_publicidade varchar (255) not null,
    validade_publicidade date not null,
    valor_publicidade decimal (6,2) not null,
    status_publicidade varchar (40) not null
);

create table tb_promocao (
	 id_promocao int not null primary key auto_increment,
     id_usuario_adm int not null,
     foreign key (id_usuario_adm) references tb_usuario (id_usuario_adm),
     id_categoria int not null,
     foreign key (id_categoria) references tb_categoria (id_categoria),
     token_promocao varchar (8) not null,
     validade_promocao date not null,
     valor_promocao decimal (6,2) not null,
     status_promocao varchar (40) not null
);

create table tb_produto (
	id_produto int not null primary key auto_increment,
    id_categoria int not null, 
    foreign key (id_categoria) references tb_categoria (id_categoria),
    id_fornecedor int not null, 
    foreign key (id_fornecedor) references tb_fornecedor (id_fornecedor),
    id_vendedor int not null, 
    foreign key (id_vendedor) references tb_vendedor (id_vendedor),
    nome_produto varchar (80) not null,
    descricao_produto text not null ,
    qtd_produto int not null,
    valor_compra_produto decimal (7,2) not null,
    valor_venda_produto decimal (7,2) not null,
    codigo_barras_produto varchar (128) not null,
    status_produto varchar (40) not null
);

create table tb_endereco_cliente (
	id_endereco int not null primary key auto_increment,
    id_usuario int not null, 
    foreign key (id_usuario) references tb_usuario (id_usuario),
    rua_endereco varchar (80) not null,
    num_endereco int not null,
    comp_endereco varchar (30),
    bairro_endereco varchar (40) not null,
    cidade_endereco varchar (40) not null,
    uf_endereco char (2) not null,
    cep_endereco char (9) not null,
    pais_endereco varchar (50) not null
);

create table tb_cartao_cliente (
	id_cartao int not null primary key auto_increment,
    id_cliente int not null,
    foreign key (id_cliente) references tb_cliente (id_cliente),
    numero_cartao char (19) not null unique,
    nome_cartao varchar (60) not null,
    validade_cartao char (7),
    csv_cartao int,
    bandeira_cartao varchar (40) not null
);

create table tb_pedido_venda (
	id_venda int not null primary key auto_increment,
    id_cliente int not null,
    foreign key (id_cliente) references tb_cliente (id_cliente),
    data_venda timestamp not null default current_timestamp,
    endereco_venda varchar (255) not null,
    pgto_venda varchar (40) not null,
    condicao_venda varchar (40) not null,
    desconto_venda decimal (6,2),
    status_venda varchar (40) not null,
    valor_venda decimal (7,2) not null,
    valor_frete_venda decimal (5,2) not null,
    empresa_entrega_venda varchar (40) not null
);

create table tb_item_venda (
	id_item_venda int not null primary key auto_increment,
    id_venda int not null,
    foreign key (id_venda) references tb_venda (id_venda),
    id_produto int not null,
    foreign key (id_produto) references tb_produto (id_produto),
    n_item_produto int not null,
    qtd_item_produto int not null,
    valor_item_produto decimal (6,2) not null
);

create table tb_imagem_produto (
	id_imagem_produto int not null primary key auto_increment,
    id_produto int not null, 
    foreign key (id_produto) references tb_produto (id_produto),
    imagem_produto varchar (255) not null
);

create table tb_boleto (
	id_boleto int not null primary key auto_increment,
    id_venda int not null,
    foreign key (id_venda) references tb_pedido_venda (id_venda),
    data_boleto date not null,
    valor_boleto decimal (7,2) not null,
    numero_boleto varchar (255) not null,
    status_boleto varchar (40) not null
);

show tables;

insert into tb_frete values
('MG', 14.99),
('RJ', 12.99),
('SP', 9.99);

INSERT INTO tb_usuario  values
(default, 'fabio@bol.com.br', '123', 'Ativo'),
(default, 'anapaula@terra.com.br', 'abc', 'Imcompleto');
select * from tb_usuario;

insert into tb_cliente (id_usuario, nome_cliente, cpf_cliente, rg_cliente, fone_cliente, dta_nasc_cliente, dta_cadastro_cliente, status_cliente) values
(1, 'Fabio Borges', '111.222.333-44', '17.444.555-x', '(11) 4455-8899', '1978-09-08', default, 'Ativo'),
(2, 'Ana Steves', '222.333.444-55', '18.555.666-7', '(11) 4477-9900', '1981-04-23', default, 'Ativo');
select * from tb_cliente;

insert into tb_vendedor values
(default, 1, 'Alpha Ltda', '02.333.000/0001-67', '(11) 4488-7799', default, 'Ativo');
select * from tb_vendedor;

insert into tb_endereco_cliente (id_endereco, id_usuario, rua_endereco, num_endereco, bairro_endereco, cidade_endereco, uf_endereco, cep_endereco, pais_endereco) values
(default, 1, 'Rua Braga','50', 'Lapa', 'Sâo Paulo', 'SP', '83750-000', 'Brasil'),
(default, 1, 'Rua Alpha','30', 'Brás', 'Sâo Paulo', 'SP', '01311-000', 'Brasil'),
(default, 2, 'Rua Beta', '100', 'Baeta Neves', 'Sâo Bernardo do Campo', 'SP', '09751-000', 'Brasil');
select * from tb_endereco_cliente;

insert into tb_cartao_cliente values
(default, 1, '4444.5555.6666.7777', 'FABIO BORGES', '2029-05', 425, 'Master Card'),
(default, 1, '4444.5566.7766.8877', 'FABIO BORGES', '2027-07', 425, 'Visa'),
(default, 2, '4433.4455.8866.9977', 'ANA P ANDRADE', '2023-03', 425, 'Master Card'),
(default, 2, '4444.5444.6333.7788', 'FABIO BORGES', '2029-05', 425, 'Visa');
select * from tb_cartao_cliente;

insert into tb_usuario_adm values
(default, 'Kaio@terra.com.br', '123', 'Ativo'),
(default, 'Laura@gmail.com', 'abc', 'Ativo');
select * from tb_usuario_adm;

insert into tb_publicidade values
(default, 1, 'URL:XXXXXXXXXXXXX', '2023-05-30', 300.00, 'Venceu'),
(default, 1, 'URL:XXXXXXXXXXXXX', '2023-06-30', 400.00, 'Ativo'),
(default, 1, 'URL:XXXXXXXXXXXXX', '2023-06-25', 600.00, 'Ativo');
select * from tb_publicidade;
desc tb_publicidade;

insert into tb_promocao values
(default, 1, 1, 'KLPX2369', '2023-06-20', 15.00, 'Válida'),
(default, 1, 2, 'KLPX2010', '2023-06-20', 20.00, 'Válida');
select * from tb_promocao;

insert into tb_fornecedor (id_fornecedor, razao_fornecedor, contato_fornecedor, fone_fornecedor, endereco_fornecedor, email_fornecedor, cnpj_fornecedor, status_fornecedor, nome_fantasia_fornecedor) values 
(default, 'Grow SA', 'Lucas', '(11) 3366-5555', 'Rua campinas 456 Itaim Sâo Paulo', 'lucas@grow.com.br', '03.444.555/0003-42', 'Ativo', 'Grow Jogos e Brinquedos'),
(default, 'SOE Sony Playstation SA', 'Paulo', '(11) 5555-4444', 'Rua Alpha, conj 07 Barra Funda Sâo Paulo ', 'paulo@soe.com.br', '03.444.555/0003-85', 'Ativo', 'Playstation Brasil'),
(default, 'Brinquedos Estrela SA', 'Julia', '(11) 4488-7744', 'Rua Omega Cambici Sâo Paulo', 'julia@estrela.com.br', '04.000.887/0004-85', 'Ativo', 'Brinquedos Estrela'),
(default, 'Microsoft Brasil SA', 'João', '(11) 5544-3333', 'Rua Beta Jardim Sâo Paulo', 'joao@soe.com.br', '03.002.898/0001-89', 'Ativo', 'Xbox Brasil');
select * from tb_fornecedor;

insert into tb_produto values
(default, 1, 1, 1, 'jogo de tabuleiro war', 'O melhor jogo de estrategia de todos os tempos!', 100, 69.99, 129.99, '1111111-2222', 'Em estoque'),
(default, 3, 2, 1, 'Videogame Playstation 5', 'Desfrute do carregamento extremamente rápido com... ', 100, 3799.99, 4499.99, '2222222-333', 'Em estoque'),
(default, 3, 4, 1, 'Videogame Xbox Series', 'A próxima geração de jogos traz a maior biblioteca di...', 100, 1799.99, 2499.99, '3333333-444', 'Em estoque'),
(default, 1, 3, 1, 'Banco Imobiliário', 'O mercado de imovéis se modernizou e está cada v...', 100, 69.99, 99.99, '4444444-555', 'Em estoque');
select * from tb_produto;

insert into tb_imagem_produto values
(default, 1, 'URL:xxxxxxxxxxxxxx'),
(default, 2, 'URL:xxxxxxxxxxxxxx'),
(default, 3, 'URL:xxxxxxxxxxxxxx'),
(default, 4, 'URL:xxxxxxxxxxxxxx');
select * from tb_imagem_produto;

select nome_produto, valor_venda_produto  from tb_produto
where valor_venda_produto = ( select max(valor_venda_produto) from tb_produto);

select nome_produto, valor_venda_produto  from tb_produto
where valor_venda_produto = ( select min(valor_venda_produto) from tb_produto);

select avg(valor_venda_produto) from tb_produto;

select COUNT(*) from tb_usuario where status_usuario = 'Ativo';

update tb_produto
set status_produto = 'Indisponível ', qtd_produto = 0 where id_produto = 4;

select date_format(validade_promocao, '%d/%m/%Y'), token_promocao, valor_promocao from tb_promocao
order by validade_promocao;

select sum(valor_publicidade) as total from tb_publicidade;






