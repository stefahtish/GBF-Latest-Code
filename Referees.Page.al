page 50478 Referees
{
    PageType = Listpart;
    SourceTable = "Applicant Referees2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Names; Rec.Names)
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field(Company; Rec.Company)
                {
                    Caption = 'Institution/Company';
                }
                field(Address; Rec.Address)
                {
                }
                field("Telephone No"; Rec."Telephone No")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field(No; Rec.No)
                {
                    Enabled = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Enabled = false;
                }
            }
        }
    }
    actions
    {
    }
}
