page 51151 "Calibration Schedule Card"
{
    Caption = 'Calibration Schedule Card';
    PageType = Card;
    SourceTable = "Lab Calibration Registration";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Maintenance No"; Rec."Maintenance No")
                {
                    ApplicationArea = All;
                    enabled = false;
                }
                field("FA No."; Rec."FA No.")
                {
                    ToolTip = 'Specifies the value of the FA No. field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field';
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                    ApplicationArea = All;
                }
                field("Service Provider Name"; Rec."Service Provider Name")
                {
                    ToolTip = 'Specifies the value of the Service Provider Name field';
                    ApplicationArea = All;
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ToolTip = 'Specifies the value of the Date of Service field';
                    ApplicationArea = All;
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                }
                field("Action"; Rec."Action")
                {
                    ToolTip = 'Specifies the value of the Action field';
                    ApplicationArea = All;
                }
                field("Next Calibration Date"; Rec."Next Calibration Date")
                {
                    ToolTip = 'Specifies the value of the Next Calibration Date field';
                    ApplicationArea = All;
                }
                field("Responsible Employee No"; Rec."Responsible Employee No")
                {
                    ToolTip = 'Specifies the value of the Responsible Employee No field';
                    ApplicationArea = All;
                }
                field("Responsible Employee name"; Rec."Responsible Employee name")
                {
                    ToolTip = 'Specifies the value of the Responsible Employee name field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    begin
                        //  FromFile := DocumentManagement.UploadDocument(Rec."Maintenance No", CurrPage.Caption, Rec.RecordId);
                    end;
                }
            }
            action("Send for calibration")
            {
                Visible = Rec."Calibration Status" = Rec."Calibration Status"::Open;
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    Rec."Calibration Status" := Rec."Calibration Status"::"On-going";
                end;
            }
            action(Complete)
            {
                Visible = Rec."Calibration Status" = Rec."Calibration Status"::"On-going";
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    Rec."Calibration Status" := Rec."Calibration Status"::Completed;
                end;
            }
        }
    }
    var
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
}
