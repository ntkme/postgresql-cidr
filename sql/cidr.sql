CREATE EXTENSION cidr;

SELECT cidr(inet '1.1.1.0', inet '1.1.1.255');

SELECT cidr(inet '1.1.1.0', inet '1.1.1.8');

SELECT cidr(inet '8.8.8.8', inet '8.255.255.255');

SELECT cidr(inet '0.0.0.0', inet '255.255.255.255');

SELECT cidr(inet '1::', inet '1:ffff:ffff:ffff:ffff:ffff:ffff:ffff');

SELECT cidr(inet '1::', inet '2::');

SELECT cidr(inet '2001:4860:4860:0000:0000:0000:0000:8888', inet '2001:4860:ffff:ffff:ffff:ffff:ffff:ffff');

SELECT cidr(inet '::', inet 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff');

SELECT cidr(inet '::', inet '1.1.0.0');

SELECT cidr(inet '1.1.1.0/24', inet '1.1.0.0/16');

SELECT cidr(inet '1.1.1.0', inet '1.1.0.0');
