page 50708 "Asset Maintenance Request"
{
    PageType = Card;
    SourceTable = "Maintenance Registration";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Maintenance No"; Rec."Maintenance No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                }
                field("FA Description"; Rec."Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Service Provider"; Rec."Service Provider")
                {
                    ApplicationArea = All;
                }
                field("Service Provider Name"; Rec."Service Provider Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Service/Repair Description"; Rec."Service/Repair Description")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ApplicationArea = All;
                }
                field("Next Service Date"; Rec."Next Service Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Driver; Rec.Employee)
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transport Manager Remarks"; Rec."Transport Manager Remarks")
                {
                    Caption = 'Admmin remarks';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec.Status = Rec.Status::Approved then begin
                            FA.Reset;
                            FA.SetRange("No.", Rec."Item No.");
                            if FA.Find('-') then begin
                                FA."Maintainence Status" := FA."Maintainence Status"::"Under Maintenence";
                                FA.Modify;
                            end;
                        end;
                    end;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Do you want to send this request for approval?', true) = false then exit;
                    Rec.Status := Rec.Status::Approved;
                end;
            }
            action("Cancel Approval")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                        FA.RESET;
                        FA.SETRANGE("No.","Item No.");
                        IF FA.FIND('-') THEN
                          BEGIN
                            FA."Maintainence Status":=FA."Maintainence Status"::Available;
                            FA.MODIFY;
                          END;
                        */
                end;
            }
            action("Mark Under Maintenance")
            {
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Do you want to mark this asset to be Under Maintenance?', true) = false then begin
                        exit
                    end;
                    if FA.Get(Rec."FA No.") then begin
                        FA."Under Maintenance" := true;
                        FA.Modify;
                    end;
                    Message('The asset has been marked Under Maintenance');
                end;
            }
            action("Return to List")
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to get the asset back to Available List?', true) = false then begin
                        exit
                    end;
                    if FA.Get(Rec."FA No.") then begin
                        FA."Under Maintenance" := false;
                        Rec.Archive := true;
                        Commit();
                        FA.Modify;
                        exit;
                    end;
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.fleet := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.fleet := false;
    end;

    var
        FA: Record "Fixed Asset";
        ApprovalsMgt: Codeunit "Approvals Mgmt.";
}
