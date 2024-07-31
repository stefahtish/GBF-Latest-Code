page 50540 "Beneficiary Cards"
{
    PageType = Card;
    SourceTable = "Employee Beneficiaries";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
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
