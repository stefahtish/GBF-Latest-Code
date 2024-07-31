page 50953 "Applicant Registrations"
{
    PageType = List;
    CardPageId = "Applicant Registration";
    SourceTable = "Licensing dairy Enterprise";
    Editable = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application no"; Rec."Application no")
                {
                }
                field("Customer Type"; Rec."Customer Type")
                {
                }
                field("Business Name"; Rec."Business Name")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Office No."; Rec."Office No.")
                {
                    Caption = 'Office Number 1';
                }
                field("E-Mail 1"; Rec."E-Mail 1")
                {
                }
                field("Registered Office"; Rec."Registered Office")
                {
                }
                field(County; Rec.County)
                {
                }
                field(SubCounty; Rec.SubCounty)
                {
                }
                field("Physical Address(Street/Road"; Rec."Physical Address(Street/Road")
                {
                    Caption = 'Postal Address';
                }
                field("Cell Phone Number 1"; Rec."Cell Phone Number 1")
                {
                }
                field("E-Mail 2"; Rec."E-Mail 2")
                {
                }
            }
        }
    }
    actions
    {
    }
}
