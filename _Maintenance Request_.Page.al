page 50493 "Maintenance Request"
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
                field("Service Interval Type"; Rec."Service Interval Type")
                {
                    ApplicationArea = All;
                }
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                }
                field("Service/Repair Description"; Rec."Service/Repair Description")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Service Period"; Rec."Service Period")
                {
                    ApplicationArea = All;
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ApplicationArea = All;
                }
                field("Current Odometer Reading"; Rec."Current Odometer Reading")
                {
                    ApplicationArea = All;
                }
                field("Service Mileage"; Rec."Service Mileage")
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
                field("Driver's Signature"; Rec."Driver's Signature")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Signature; Rec.Signature)
                {
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
                field("Service LSO/LPO No."; Rec."Service LSO/LPO No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Archive; Rec.Archive)
                {
                    Enabled = false;
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
                    if Confirm('Do you want to mark this Vehicle to be Under Maintenance?', true) = false then begin
                        exit
                    end;
                    if FA.Get(Rec."FA No.") then begin
                        FA."Under Maintenance" := true;
                        FA.Modify;
                    end;
                    Message('The Vehicle has been marked Under Maintenance');
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
                    if Confirm('Do you wish to get the Vehicle back to Available List?', true) = false then begin
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
            action("Job card")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    MaintenanceReg: Record "Maintenance Registration";
                begin
                    MaintenanceReg.RESET;
                    MaintenanceReg.SETRANGE("Maintenance No", Rec."Maintenance No");
                    REPORT.RUN(Report::"Maintenace Job Card", TRUE, FALSE, MaintenanceReg);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.fleet := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.fleet := true;
    end;

    var
        FA: Record "Fixed Asset";
        ApprovalsMgt: Codeunit "Approvals Mgmt.";

    procedure VehUnderMaintainence()
    begin
        FA.Reset;
        FA.SetRange("No.", Rec."Item No.");
        if FA.Find('-') then begin
            FA."Maintainence Status" := FA."Maintainence Status"::"Under Maintenence";
            FA.Modify;
        end;
    end;

    procedure VehReturn()
    begin
        FA.Reset;
        FA.SetRange("No.", Rec."Item No.");
        if FA.Find('-') then begin
            FA."Maintainence Status" := FA."Maintainence Status"::Available;
            FA.Modify;
        end;
    end;
}
