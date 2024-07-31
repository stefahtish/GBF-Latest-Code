page 50539 "Employee Beneficiaries"
{
    CardPageID = "Beneficiary Cards";
    PageType = List;
    SourceTable = "Employee Beneficiaries";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field("Employee No."; Rec."Employee No.")
                {
                    Visible = false;
                }
                field("Beneficiary No."; Rec."Beneficiary No.")
                {
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
            }
        }
    }
    actions
    {
    }
}
