page 50467 "Applicant Qualification"
{
    PageType = ListPart;
    SourceTable = "Applicants Qualification";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;

                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                }
                field(Qualification; Rec.Qualification)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field(Institution_Company; Rec.Institution_Company)
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field(Score; Rec.Score)
                {
                    Editable = false;
                }
                field(Qualified; Rec.Qualified)
                {
                    Enabled = false;
                }
                field(No; Rec.No)
                {
                    Enabled = false;
                }
                field("Need Code"; Rec."Need Code")
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
