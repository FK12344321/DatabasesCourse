explain select * from customer where name = 'Monica Franklin'; -- 27ms
explain select * from customer where address = '0983 Scott Ridge
Ebonymouth, NV 04873'; -- 16ms
explain select * from customer where review = 'Character area involve once. Religious purpose experience arm than fill fly point. Recent dream rather test use.'; -- 17ms

CREATE INDEX hash_index ON customer USING hash(name);
CREATE INDEX btree_index ON customer USING btree(address);

explain select * from customer where name = 'Steven Mcclain'; -- 22ms
explain select * from customer where address = '2859 Shaw Landing
Port Markchester, ND 31721'; -- 13ms
explain select * from customer where review = 'Focus relate response full animal wonder. Religious put truth remember.
Option husband economy note coach. Best organization trip life method.'; -- 15ms

-- you can see the results in the forms of comments after the queries
-- after the execution of the queries, the hash index gave a 5ms decrease,
-- while btree gave 3ms