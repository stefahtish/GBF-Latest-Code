page 51037 "Prospective Board of Directors"
{
    Caption = 'Company Directors';
    PageType = ListPart;
    SourceTable = "Prospective Supplier Directors";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Salutation; Rec.Salutation)
                {
                    Caption = 'Designation';
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'Identity Card or Passport number';
                    ToolTip = 'Specifies the value of the ID No. field';
                    ApplicationArea = All;
                }
                field("Email address"; Rec."Email address")
                {
                    ApplicationArea = all;
                }
                field("Telephone Number"; Rec."Telephone Number")
                {
                    ApplicationArea = all;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = all;
                }
                field("Prospect No."; Rec."Prospect No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prospect No. field';
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No field';
                    ApplicationArea = All;
                }
                field(Ethnicity; Rec.Ethnicity)
                {
                    ApplicationArea = all;
                }
                field("Ethnicity Description"; Rec."Ethnicity Description")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }
}
