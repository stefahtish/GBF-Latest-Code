page 51290 "Applicant Prof Membership Card"
{
    Caption = 'Applicant Prof Membership Card';
    PageType = Card;
    SourceTable = "Applicant Prof Membership2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                }
                field("Professional Body"; Rec."Professional Body")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(MembershipNo; Rec.MembershipNo)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
            }
        }
    }
}
