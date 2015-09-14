function fish_prompt --description 'Write out the prompt'

	set -l last_status $status

	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

	# PWD
	set_color $fish_color_cwd
	echo -n (prompt_pwd)
	set_color normal

	printf '%s ' (__fish_git_prompt)
	
	#check se é diretório git
	set -l git_dir (git rev-parse --git-dir 2> /dev/null)
  	if test -n "$git_dir"
		set -l stash_number (git stash list | wc -l)
		if not test $stash_number -eq 0
			set_color $fish_color_quote
			printf '#%s '  $stash_number
			set_color normal
		end
	end

	if not test $last_status -eq 0
		set_color $fish_color_error
	end
	
	echo -n '$ '

	if set -q VIRTUAL_ENV
    		echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
	end
end
