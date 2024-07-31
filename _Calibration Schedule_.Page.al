page 51141 "Calibration Schedule"
{
    Caption = 'Calibration Schedule';
    PageType = List;
    Editable = false;
    SourceTable = "Lab Calibration Registration";
    cardpageid = "Calibration Schedule Card";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Maintenance No"; Rec."Maintenance No")
                {
                    ApplicationArea = All;
                }
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                // field("Item No."; Rec."Item No.")
                // {
                //     ApplicationArea = All;
                // }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Calibration Method"; Rec."Calibration Method")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Service Provider Name"; Rec."Service Provider Name")
                {
                }
                field("Date of Service"; Rec."Date of Service")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
