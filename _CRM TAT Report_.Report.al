report 50333 "CRM TAT Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CRMTATReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(InteractionHeader; "Client Interaction Header")
        {
            RequestFilterFields = "Interact Code", "Client Type", "Client No.", "Interaction Type", "Interaction Channel";

            column(InteractCode_InteractionHeader; InteractionHeader."Interact Code")
            {
            }
            column(DateandTime_InteractionHeader; InteractionHeader."Date and Time")
            {
            }
            column(ClientNo_InteractionHeader; InteractionHeader."Client No.")
            {
            }
            column(InteractionTypeNo_InteractionHeader; InteractionHeader."Interaction Type No.")
            {
            }
            column(InteractionResolutionNo_InteractionHeader; InteractionHeader."Interaction Resolution No.")
            {
            }
            column(UserID_InteractionHeader; InteractionHeader."User ID")
            {
            }
            column(Status_InteractionHeader; InteractionHeader.Status)
            {
            }
            column(InteractionType_InteractionHeader; InteractionHeader."Interaction Type")
            {
            }
            column(ClientName_InteractionHeader; InteractionHeader."Client Name")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompAddress; CompInfo.Address)
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(CompPic; CompInfo.Picture)
            {
            }
            dataitem(ResTasks; "Resolution of Tasks Status")
            {
                DataItemLink = "Interaction Header No." = FIELD("Interact Code");

                column(ResolutionCode_ResTasks; ResTasks."Interaction Header No.")
                {
                }
                column(InterationResoCode_ResTasks; ResTasks."Interation Reso. Code")
                {
                }
                column(StepNo_ResTasks; ResTasks."Step No.")
                {
                }
                column(ResolutionDescription_ResTasks; ResTasks."Resolution Description")
                {
                }
                column(ResolutionStatus_ResTasks; ResTasks."Resolution Status")
                {
                }
                column(DocumentNo_ResTasks; ResTasks."Document No")
                {
                }
                column(AssignedUserFrom_ResTasks; ResTasks."Assigned User From")
                {
                }
                column(AssignedDateFrom_ResTasks; ResTasks."Assigned Date From")
                {
                }
                column(AssignedUserTo_ResTasks; ResTasks."Assigned User To")
                {
                }
                column(AssignedDateTo_ResTasks; ResTasks."Assigned Date To")
                {
                }
                column(ActionTaken_ResTasks; ResTasks."Action Taken")
                {
                }
                column(ActionStatus_ResTasks; ResTasks."Action Status")
                {
                }
                column(HeaderStatus_ResTasks; ResTasks."Header Status")
                {
                }
                column(NoOfDays; NoOfDays)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    // ResTasks.SETFILTER("Assigned Date From",'<>%1',0DT);
                    // ResTasks.SETFILTER("Assigned Date To",'<>%1',0DT);
                    // IF ResTasks.FIND('-') THEN
                    // NoOfDays:=FORMAT(ResTasks."Assigned Date From"-ResTasks."Assigned Date To");
                    // ResTasks.SETFILTER("Assigned Date To",'<>%1',0DT);
                    // IF NOT ((ResTasks."Assigned Date From"=0DT) AND (ResTasks."Assigned Date To"=0DT)) THEN
                    // NoOfDays:=FORMAT(ResTasks."Assigned Date From"-ResTasks."Assigned Date To");
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        NoOfDays: Text;
}
