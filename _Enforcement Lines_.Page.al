page 50946 "Enforcement Lines"
{
    Caption = 'Enforcement Lines';
    PageType = ListPart;
    SourceTable = "Enforcement Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field(Instituition; Rec.Instituition)
                {
                    ApplicationArea = All;
                }
                field("Huduma Number"; Rec."Huduma Number")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
