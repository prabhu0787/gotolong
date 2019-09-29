#!/bin/sh

# To be invoked from following folder with a layout of in-xls and out-csv
# D:\GoogleDrive\my_personal_pack\invest\Equity\icici-bank-txn-data

local_repo_root=/d/GoogleDrive/my_github/GitHub
local_repo_name="gotolong"
debug_level=1

in_dir=in-xls
out_dir=out-csv

bank=icici-bank

for fy_dir in `ls ${in_dir}`
do
	if test -d ${in_dir}/${fy_dir}
	then
		mkdir -p ${out_dir}/${fy_dir}/${bank}

		in_file=${in_dir}/${fy_dir}/OpTransactionHistory-${fy_dir}.xls
		out_file=${out_dir}/${fy_dir}/${bank}/OpTransactionHistory-${fy_dir}.csv

		echo processing ${fy_dir}
	        python  "${local_repo_root}/${local_repo_name}/src/dividend/excel_to_csv.py" ${in_file} ${out_file} ${debug_level}

        fi
done
