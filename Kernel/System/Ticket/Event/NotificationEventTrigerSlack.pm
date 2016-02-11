package Kernel::System::Ticket::Event::NotificationEventTriggerSlack;
use Moose;

extends 'Kernel::System::Ticket::Event::NotificationEvent';

=head1 NAME

Kernel::System::Ticket::Event::NotificationEventTriggerSlack - wrapper fot notification triger ,try to triger slack api

=cut

around 'Run' => sub {
      my $orig = shift;
      my $self = shift;

      $result = $self->$orig(@_);
      #after send base notification and email
      if( $result ) {
            #send
      }
      #return what's we got from notification trigger.
      return $result;
};

1;
