report 50295 "Employee Bank/FOSA Accounts"
{
    ApplicationArea = All;
    dataset
    {
        dataitem(EmployeeBankAccounts; "Employee Bank Accounts")
        {
            column(Employee_No_; "Employee No.")
            {
            }
            column(Bank; Bank)
            {
            }
            column(Branch; Branch)
            {
            }
            column(Account_number; "Account number")
            {
            }
            dataitem("Assignment Matrix-X"; "Assignment Matrix-X")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
