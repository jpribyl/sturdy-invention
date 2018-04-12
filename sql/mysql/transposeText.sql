use exercises;

drop procedure if exists transposeText;
delimiter $$
create
procedure transposeText(
	in word varchar(50),
	out word_transpose varchar(50)
)

begin
	declare finished boolean default false;
	declare cur_letter int default 0;
	declare word_length int default char_length(word);
	declare transpose varchar(50) default "\n";

	while cur_letter <= word_length do
		select substring(word, cur_letter, 1);
		set cur_letter = cur_letter + 1;
		set transpose = concat(transpose, "\n", substring(word, cur_letter, 1));
	end while;

	select transpose into word_transpose;


end$$
delimiter ;

call transposeText("capone", @transpose);
select @transpose;
